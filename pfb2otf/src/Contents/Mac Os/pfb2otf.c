#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>

/*
 * File exists
 */
int file_exists(const char* filename) {
	struct stat statbuf;
	return stat(filename, &statbuf) == 0;
}

/*
 * Exec
 */
void exec(const char *command){
	fprintf(stdout, "running command: %s\n", command);
	char line[256];
	FILE *fpipe;
	if ( !(fpipe = (FILE*)popen(command,"r")) ){  // If fpipe is NULL
		fprintf(stdout, "Problems with pipe");
		perror("Problems with pipe");
		exit(1);
	}
			
	while ( fgets( line, sizeof line, fpipe)){
		puts(line);
	}
	pclose(fpipe);
}


/*
 * Main
 */
int main (int argc, const char * argv[]) {
	// TODO: Add Optional -path for fontforgre trough air as a preferences.
	if( file_exists("/usr/local/bin/fontforge") ){
		
		const char *path = (const char *)argv[1];
		int i = 2;
		const char *arg;
		const char *format = "/usr/local/bin/fontforge -script %s/pfb2otf.py %s";
		char command[1024];
		int ret;
		for (; i < argc; i++) {
			arg = argv[i];
			ret = snprintf(command, 1024, format, path, arg);
			if(ret != -1){
				exec(command);
			}
		}
	}
	fprintf(stdout, "0\n");
	return 0;
}



