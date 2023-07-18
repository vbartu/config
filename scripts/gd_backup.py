#! /usr/bin/python3
import os

DIRS = [
    ("~/documents/tychetools", "tychetools"),
    ("~/documents/uni", "uni"),
    ("~/documents/boring", "boring"),
    ("~/documents/cv", "cv"),
    ("~/documents/freelance", "freelance"),
]


def rclone(local_dir: str, gd_dir: str):
    local_dir = os.path.expanduser(local_dir)
    os.system("/usr/bin/rclone copy --update --verbose --transfers 30"
              " --checkers 8 --contimeout 60s --timeout 300s --retries 3"
              f" --low-level-retries 10 --stats 1s \"{local_dir}\""
              f" google-drive:backup/{gd_dir}")


def main():
    for local_dir, gd_dir in DIRS:
        rclone(local_dir, gd_dir)


if __name__ == "__main__":
    main()
