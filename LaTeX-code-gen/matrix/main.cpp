#include <cstdio>

#include <iostream>
#include <vector>

#include <base.h>

char output[OUTPUT_SIZE];

auto main(int argc, char *argv[]) -> int {
    int m, n;

    std::cin >> m >> n;

    std::vector<std::vector<int>> mtx(m, std::vector<int>(n));
    for (auto &mline : mtx) {
        for (auto &i : mline) {
            std::cin >> i;
        }
    }

    // std::string output("\\begin{pmatrix}\n");
    char *ptr = output;
    ptr += sprintf(ptr, "\\begin{pmatrix}\n");
    for (int i = 0; i < m; ++i) {
        // output += "    ";
        // ptr += "    ";
        ptr += sprintf(ptr, "    ");
        for (int j = 0; j < n; ++j) {
            // output += std::to_string(mtx[i][j]);
            ptr += sprintf(ptr, "%3d", mtx[i][j]);
            if (j == n - 1) {
                // output += "\t\\\\\n";
                ptr += sprintf(ptr, " \\\\\n");
            } else {
                // output += "\t&\t";
                ptr += sprintf(ptr, " & ");
            }
        }
    }
    // output += "\\end{pmatrix}\n";
    sprintf(ptr, "\\end{pmatrix}\n");

    printf("%s", output);

    return 0;
}
