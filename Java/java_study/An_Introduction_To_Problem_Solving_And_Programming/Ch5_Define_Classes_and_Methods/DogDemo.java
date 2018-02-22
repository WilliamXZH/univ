public class DogDemo
{
	public static void main(String[] args)
	{
		Dog balto = new Dog();
		balto.name = "Balto";
		balto.age = 8;
		balto.breed = "Siberian Husky";
		balto.writeOutput();

		Dog scooby = new Dog();
		scooby.name = "Scooby";
		scooby.age = 42;
		scooby.breed = "Great Dane";
		System.out.println();
	}
}