class employee
{
	protected:
		char name[20];
		int individualEmpNo;
		int grade;
		float accumPay;
		static int employeeNo;
	public:
		employee();
		~employee();
		void pay();
		void promote(int);
		void SetName(char *);
		char * GetName();
		void SetaccumPay(float pa);
		int GetindividualEmpNo();
		int Getgrade();
		float GetaccumPay();
};
class technician:public employee
{
	private:
		float hourlyRate;
		int workHours;
	public:
		technician();
		void SetworkHours(int wh);
		void pay();
};
class salesman:virtual public employee
{
	protected:
		float CommRate;
		float sales;
	public:
		salesman();
		void Setsales(float sl);
		void pay();
};
class manager:virtual public employee
{
	protected:
		float monthlyPay;
	public:
		manager();
	void pay();
};
class salesmanager:public manager,public salesman
{
	public:
		salesmanager();
		void pay();
};

