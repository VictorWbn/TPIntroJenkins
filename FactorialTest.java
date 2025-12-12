import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class FactorialTest {
    @Test
    public void testFactorial() {
        Factorial f = new Factorial();
        assertEquals(120, f.factorial(5));
        assertEquals(1, f.factorial(0));
    }
}