import subprocess

password = "123456"

user_input = input("Enter command: ")
subprocess.call(user_input, shell=True)
