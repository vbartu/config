import os
import re

LOG = "/home/vicente/pacman.log"
CACHE_DIR = "/var/cache/pacman/pkg"

def check_cache(pkg, version):
    pkg_name = f"{pkg}-{version}"
    for file in os.listdir(CACHE_DIR):
        if file[-4:] == ".sig":
            continue
        if file[0:len(pkg_name)] == pkg_name:
            return file
    return None


def main():
    with open(LOG) as f:
        lines = f.readlines()

    n = 0
    errors = []
    version_pattern = re.compile("\[ALPM\] upgraded ([0-9a-z-\+]+) \(([0-9a-z-\.:\+]+) -> ([0-9a-z-\.]+)")
    upgrade_pattern = re.compile("\[ALPM\] upgraded")
    for line in lines:
        match = upgrade_pattern.search(line)
        if match:
            match = version_pattern.search(line)
            if match:
                pkg, old_ver, ver = match.groups()
                pkg_file = check_cache(pkg, old_ver)
                if pkg_file:
                    n += 1
                    cmd = f"pacman -U --noconfirm {CACHE_DIR}/{pkg_file}"
                    print(cmd)
                    os.system(cmd)
                else:
                    error = f"Unable to downgrade pkg {pkg} to version {old_ver}"
                    print(error)
                    errors.append(error)
            else:
                error = "Unable to parse \"{}\"".format(line[:-1])
                print(error)
                errors.append(error)

    print(f"\nFinished: {n} packages downgraded")
    if errors:
        print(f"{len(errors)} packages couldn't be downgraded:")
    for error in errors:
        print(error)


if __name__ == "__main__":
    main()
