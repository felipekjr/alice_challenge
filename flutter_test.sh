# variables
CYAN=$'\e[0;36m'
NC='\033[0m'
packages=0

runTests() {
    testDir=$1
    echo "\n${CYAN}$1${NC}" 
    if [ -d "$testDir" ]; then
        cd "$testDir"
        flutter test --no-test-assets --coverage . && packages=$((packages+1))
        lcov \
            --quiet \
            --remove coverage/lcov.info \
            --output-file coverage/coverage.info \
            "lib/src/*_resolver.dart" \
            "lib/src/core/factories/*" \
            "lib/src/domain/entities/*"
        genhtml coverage/coverage.info -o coverage/html
        cd -
    else echo "No test found"
    fi
}

echo "Package name: "
read -r input
runTests "$input"
