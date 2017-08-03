import grading.projects as projects
import subprocess
import os
from unittest import mock

def run_command(command, **subprocess_options):
    completed_process = subprocess.run(command, stdout=subprocess.PIPE,
        stderr=subprocess.PIPE, **subprocess_options)

    stdout = completed_process.stdout.decode()
    stderr = completed_process.stderr.decode()
    return_code = completed_process.returncode

    return (return_code, stdout, stderr)

def run_multiple_files_with_project_factory(factory_name, project_directory, input_file_name):
    factory = projects.get_factory_from_name(factory_name)

    project = factory.create_from_directory(project_directory)

    with open(input_file_name) as input_file:
        return project.run(input_file)

def test_java8_factory():
    with mock.patch('grading.projects._run_in_sandbox', run_command):
        return_code, stdout, stderr = run_multiple_files_with_project_factory("java8",
            "tests/test_grading/sample_code/projects/qb64-parser",
            "tests/test_grading/sample_code/projects/qb64-parser/casos/in01.txt")

        print("stderr:" + stderr)
        print("stdout:" + stdout)

        with open("tests/test_grading/sample_code/projects/qb64-parser/casos/out01.txt") as output_file:
            output = output_file.read()
            assert return_code == 0
            assert stdout == output
            assert stderr == ""
