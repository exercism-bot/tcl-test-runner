#! /bin/sh

# Synopsis:
# Test the test runner by running it against a predefined set of solutions 
# with an expected output.

# Output:
# Outputs the diff of the expected test results against the actual test results
# generated by the test runner.

# Example:
# ./bin/run-tests.sh

exit_code=0

export RUN_ALL=yes

# Iterate over all test directories
for test_dir in tests/*; do
    test_dir_name="$(basename $test_dir)"
    test_dir_path="$(realpath $test_dir)"
    results_file="results.json"
    results_file_path="${test_dir}/results.json"
    expected_results_file="expected_results.json"
    expected_results_file_path="${test_dir}/expected_results.json"    

    if [ -f "${expected_results_file_path}" ]; then
        echo "===="
        bin/run.tcl "${test_dir_name}" "${test_dir}" "${test_dir}"
        echo "===="

        echo "${test_dir_name}: comparing ${results_file} to ${expected_results_file}"
        if diff "${results_file_path}" "${expected_results_file_path}"; then
            # exit status zero: no diff
            echo OK
        else
            exit_code=1
        fi
    fi
done

exit ${exit_code}
