#include <thread>

#include <iostream>

#include <mutex>

#include <queue>

#include <condition_variable>

#include <atomic>

using namespace std;

int main()
{

    mutex lockBuffer; //申明互斥信号量

    volatile bool ArretDemande = false; //使生产、消费过程的结束

    queue<long> buffer;       

    condition_variable_any cndNotifierConsommateurs;//condition variable

    condition_variable_any cndNotifierProducteur;   
 
    thread ThreadProducteur([&]()//生产者线程
    {
       
        std::atomic<long> interlock;//对interlock的操作将是原子的

        interlock=1;   

        while(true)
        {               

                std::this_thread::sleep_for (chrono::milliseconds (15));               

                long element=interlock.fetch_add (1);//【1】

                lockBuffer.lock ();

                while(buffer.size()==10 && ArretDemande ==false)
                {
                   
                    cndNotifierProducteur.wait (lockBuffer);//【2】

                }

                if (ArretDemande==true)

                {                   

                    lockBuffer.unlock ();

                    cndNotifierConsommateurs.notify_one ();//【3】

                    break;

                }

                buffer.push(element);

                cout << "Production unlement :" << element << " size :" << buffer.size() << endl;

                lockBuffer.unlock ();

                cndNotifierConsommateurs.notify_one ();

        }

    } );

    thread ThreadConsommateur([&]()
    {
      
        while(true)
            {
               
                lockBuffer.lock ();

                while(buffer.empty () && ArretDemande==false)

                {                   

                    cndNotifierConsommateurs.wait(lockBuffer);

                }

                if (ArretDemande==true && buffer.empty ())

                {

                    lockBuffer.unlock();

                    cndNotifierProducteur.notify_one ();

                    break;

                }

                long element=buffer.front();

                buffer.pop ();

                cout << "Consommation element :" << element << " size :" << buffer.size() << endl;

                lockBuffer.unlock ();

                cndNotifierProducteur.notify_one ();

            }           

    } );

    std::cout << "Pour arreter pressez [ENTREZ]" << std::endl;

    getchar();

    std::cout << "Arret demande" << endl
    ArretDemande=true;

    ThreadProducteur.join();
    ThreadConsommateur.join();

    cout<<"Main Thread"<<endl;

    return 0;

}