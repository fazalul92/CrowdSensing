package edu.rit.se.creativecrowd;

import java.util.Random;

public class NameGen {
	public String getName() {
		String[] fname = {"Wyatt", "Herb", "Reyes", "Alphonse", "Jeffry", "Miles", "Mose", "Buford", "Gregorio", "Hal", "Antione", "Jackson", "Chase", "Whitney", "Danial", "Hershel", "Harland", "Salvador", "Landon", "Darrel", "Zachariah", "Alden", "Buster", "Rueben", "Basil", "Claude", "Elliott", "Cedric", "Otha", "Clayton", "Stanley", "Don", "Fritz", "Sergio", "Newton", "Cleveland", "Gustavo", "Kristofer", "Keneth", "Drew", "Aubrey", "Julius", "Ezekiel", "Adalberto", "Brad", "Chance", "Walton", "Conrad", "Royal", "Frederic"};
		String[] lname = {"Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "Garcia", "Rodriguez", "Wilson", "Martinez", "Anderson", "Taylor", "Thomas", "Hernandez", "Moore", "Martin", "Jackson", "Thompson", "White", "Lopez", "Lee", "Gonzalez", "Harris", "Clark", "Lewis", "Robinson", "Walker", "Perez", "Hall", "Young", "Allen", "Sanchez", "Wright", "King", "Scott", "Green", "Baker", "Adams", "Nelson", "Hill", "Ramirez", "Campbell", "Mitchell", "Roberts", "Carter", "Phillips", "Evans"};
		Random rand = new Random();
		int rand1 = rand.nextInt(50);
		int rand2 = rand.nextInt(50);
		return fname[rand1]+" "+lname[rand2];
	}
}
