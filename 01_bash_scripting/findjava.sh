found=$(java -version 2>&1)
exit_code=$?
echo "java version $found"
echo "exit code $exit_code"
