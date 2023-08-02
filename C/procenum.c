#include <stdio.h>
#include <windows.h>

typedef struct tagPROCESSENTRY32 {
	DWORD     dwSize;
	DWORD     cntUsage;
	DWORD     th32ProcessID;              // The process ID
	ULONG_PTR th32DefaultHeapID;
	DWORD     th32ModuleID;
	DWORD     cntThreads;
	DWORD     th32ParentProcessID;        // Process ID of the parent process
	LONG      pcPriClassBase;
	DWORD     dwFlags;
	CHAR      szExeFile[MAX_PATH];        // The name of the executable file for the process
} PROCESSENTRY32;

BOOL GetPid(LPWSTR szProcessName, DWORD* dwProcessId, HANDLE* hProcess) {
	// dwSize has to be initialized, otherwise Process32First will fail
	PROCESSENTRY32	Proc = {
		.dwSize = sizeof(PROCESSENTRY32)
	};

	HANDLE hSnapShot = NULL;

	// Take a snapshot of running processes
	hSnapShot = CreateToolhelp32Snapshot(0x00000002, NULL);
	if (hSnapShot == INVALID_HANDLE_VALUE) {
		printf("\n[!] CreateToolhelp32Snapshot Failed With Error : %d \n", GetLastError());
		goto _EndOfFunction;
	}

	// Retrieves information about the first process encountered in the snapshot.
	if (!Process32First(hSnapShot, &Proc)) {
		printf("\n[!] Process32First Failed With Error : %d \n", GetLastError());
		goto _EndOfFunction;
	}

	do {
		WCHAR LowerName[MAX_PATH * 2];

		if (Proc.szExeFile) {
			DWORD	dwSize = lstrlenW(Proc.szExeFile);
			DWORD   i = 0;

			RtlSecureZeroMemory(LowerName, MAX_PATH * 2);

			// Convert to lowercase and save to LowerName
			if (dwSize < MAX_PATH * 2) {

				for (; i < dwSize; i++)
					LowerName[i] = (WCHAR)tolower(Proc.szExeFile[i]);

				LowerName[i++] = '\0';
			}
		}

		// Check if LowerName matches the provided name
		if (wcscmp(LowerName, szProcessName) == 0) {
			// Save the PID
			*dwProcessId = Proc.th32ProcessID;
			// Open a handle to the process
			*hProcess = OpenProcess(PROCESS_ALL_ACCESS, FALSE, Proc.th32ProcessID);
			if (*hProcess == NULL)
				printf("[!] OpenProcess Failed With Error : %d \n", GetLastError());

			break;
		}

		// Loop through all processes in the snapshot and retrieve info about each
	} while (Process32Next(hSnapShot, &Proc));

	// Cleanup
_EndOfFunction:
	if (hSnapShot != NULL)
		CloseHandle(hSnapShot);
	if (*dwProcessId == NULL || *hProcess == NULL)
		return FALSE;
	return TRUE;
}

void main() {
	LPWSTR szProcessName = L"notepad.exe";
	DWORD* dwProcessId = 0;
	HANDLE* hProcess = NULL;
	if (GetPid(szProcessName, &dwProcessId, &hProcess)) {
		printf("\n[i] Process %ls found with ID %d", szProcessName, dwProcessId);
		CloseHandle(hProcess);
	}
	else {
		printf("\n[i] Process %s not found", szProcessName);
	}
}
