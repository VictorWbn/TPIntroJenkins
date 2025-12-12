public class Factorial {
    public int factorial(int n) {
        if (n < 0) throw new IllegalArgumentException("Nombre négatif non autorisé");
        if (n == 0 || n == 1) return 1;
        return n * factorial(n - 1);
    }

    public static void main(String[] args) {
        Factorial f = new Factorial();
        int num = 5;
        System.out.println("Factorielle de " + num + " est : " + f.factorial(num));
    }
}