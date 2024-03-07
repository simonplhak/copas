import subprocess
from socket import *

serverPort = 8080
serverSocket = socket(AF_INET, SOCK_STREAM)
serverSocket.bind(('', serverPort))
serverSocket.listen(1)
print('The server is ready to receive')
while True:
    connectionSocket, addr = serverSocket.accept()
    searched_movie = connectionSocket.recv(1024).decode()
    command = f'grep -i "{searched_movie}" /workdir/games.csv | awk -F "," \'{{print "Title: "$1", Rating: "$3", Minimal Age: "$2}}\''
    print(command)
    try:
        process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
        response, stderr = process.communicate()
        if process.returncode != 0:
            response = f'Error: stdout={response.decode()}, {stderr=}'.encode()
    except Exception as e:
        response = f'Error: {str(e)}'.encode()
    print(response)
    connectionSocket.send(response)
    connectionSocket.close()
