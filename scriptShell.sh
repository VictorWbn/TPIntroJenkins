echo "Environnement sélectionné : $ENVIRONMENT"

# Étape 1 : Gestion des dépendances (JUnit)
JUNIT_JAR="junit-platform-console-standalone-1.9.3.jar"

if [ ! -f "$JUNIT_JAR" ]; then
    echo "Téléchargement de JUnit..."
    wget https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.9.3/junit-platform-console-standalone-1.9.3.jar
fi

# Étape 2 : Compilation
echo "--- Compilation ---"
mkdir -p out
javac -d out -cp $JUNIT_JAR:. Factorial.java FactorialTest.java
if [ $? -ne 0 ]; then
    echo "ERREUR DE COMPILATION"
    exit 1
fi

# Étape 3 : Exécution des tests
echo "--- Tests Unitaires ---"
java -jar $JUNIT_JAR -cp out --scan-classpath
if [ $? -ne 0 ]; then
    echo "LES TESTS ONT ÉCHOUÉ"
    exit 1
fi

# Étape 4 : Génération du JAR
echo "--- Packaging (.jar) ---"
echo "Main-Class: Factorial" > Manifest.txt
jar cfm factorial-app.jar Manifest.txt -C out .
echo "Fichier factorial-app.jar généré avec succès."

# Étape 6 : Exécution conditionnelle
echo "--- Déploiement Conditionnel ---"
if [ "$ENVIRONMENT" = "prod" ]; then
    echo ">>> DÉPLOIEMENT EN PRODUCTION EN COURS..."
    # Simuler un déploiement
    sleep 2
    echo ">>> Déploiement terminé."
elif [ "$ENVIRONMENT" = "test" ]; then
    echo ">>> Exécution de tests d'intégration supplémentaires..."
else
    echo ">>> Environnement de DEV : Pas d'action supplémentaire."
fi

echo "FIN"