#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import sys
import subprocess
import platform
import shlex
import glob
import errno
import shutil

try:
    import argparse
except ImportError:
    sys.exit("Please install or run Python 2.7 or later")


HOME = os.path.expanduser("~")  # User Home Directory
DOTFILES = os.path.join(HOME, ".dotfiles")
ALL_DOTFILES = set(x[len(DOTFILES+"/"):] for x in glob.glob(DOTFILES + "/.*"))
# 除外するファイル名の設定
LINUX_DOTS = set([".xinitrc", ".i3", ".Xresources", ".colors", ".gtkrc-2.0"])
EXCLUDE_DOTFILES = set([".git", ".git_commit_template.txt", "README.md", ".gitignore", ".travis.yml", ".gitmodules", "dependencies", "Linux", "install.sh", "install.py", ".xinitrc", ".i3", ".Xresources", ".colors", ".gtkrc-2.0"])
# ホームディレクトリ上にシンボリックリンクを貼るファイルの名前
DOT_HOME_FILES = ALL_DOTFILES - EXCLUDE_DOTFILES


class FormatedColor:
    SUCCESS = "\033[92m"  # Green
    WARNING = "\033[93m"  # Yello
    DANGER = "\033[91m"   # Red
    PRIMARY = "\033[94m"  # Blue
    BOLD = "\033[1m"
    END = "\033[0m"

    def init(self):
        pass

    def pprint(self, header, msg, end=END):
        print(header + msg + end)

    def success(self, msg):
        self.pprint(self.SUCCESS, msg)

    def fail(self, msg):
        self.pprint(self.DANGER, msg)

    def warn(self, msg):
        self.pprint(self.WARNING, msg)

    def info(self, msg):
        self.pprint(self.BOLD, msg)


f = FormatedColor()

def run(os_command):
    """os_command is linux command, eg: git clone https://github.com/..."""
    try:
        subprocess.check_call(shlex.split(os_command))
    except subprocess.CalledProcessError as e:
        f.fail("✗ Execution command failure: %s" % os_command)
        return False
    return True


def which(pgm):
    path = os.getenv("PATH")
    for p in path.split(os.path.pathsep):
        p = os.path.join(p, pgm)
        if os.path.exists(p) and os.access(p, os.X_OK):
            return True
    return False

def install_required():
    from sys import platform as _platform
    dist = ""
    if _platform == "linux" or _platform == "linux2":
        dist = platform.dist()[0]
    elif _platform == "darwin":
        dist = "macOS"
    elif _platform == "win32":
        dist = "Windows"
    command = "bash {dotfiles}/dependencies/dependencies-{dist}".format(dist=dist, dotfiles=DOTFILES)
    f.info(command)
    return True if run(command) else False

def has_required():
    REQUIRED_COMMAND = ("tmux", "zsh", "nvim", "git")
    rest = list(filter(lambda x: not which(x), REQUIRED_COMMAND))
    if rest != []:
        f.warn("Please install the command. " + ", ".join(rest))
        return False
    return True


def downloading_dotfiles(branch="master"):
    REPOS_URL = "https://github.com/Croxed/dotfiles.git"
    # git clone --recursive ${REPO_URL} ${DOTFILES}
    # git  --recursive option is then do submodule init & submodule update
    f.info("Clone repository. branch is " + branch)
    command = "git clone -b {branch} {repo} {dst}".format(
            branch=branch, repo=REPOS_URL, dst=DOTFILES)
    f.info(command)
    return True if run(command) else False

def install_extras():
    from sys import platform as _platform
    install = ""
    installpath = ""
    linux = False
    if _platform == "linux" or _platform == "linux2":
        linux = True
    elif _platform == "darwin":
        install = "{dotfiles}/dependencies/macos".format(dotfiles=DOTFILES)

    if linux:
        for dfs in LINUX_DOTS:
            src = os.path.join(DOTFILES, dfs)
            dst = os.path.join(HOME, dfs)

            try:
                os.symlink(src, dst)
                f.success("✓ linking {src} ==> {dst}".format(src=src, dst=dst))
            except OSError as e:
                if e.errno == errno.EEXIST:
                    f.warn("{src} ==> {dst} already exists".format(src=src, dst=dst))
                    if query_yes_no("Do you want to overwrite the conflicting file?"):
                        if os.path.isdir(dst):
                            shutil.rmtree(dst)
                        else:
                            os.remove(dst)
                        os.symlink(src, dst)
        return True
    else:
        command = "bash {install}".format(
                install=install)
        f.info(command)
        return True if run(command) else False

def deploy():
    for dfs in DOT_HOME_FILES:
        src = os.path.join(DOTFILES, dfs)
        dst = os.path.join(HOME, dfs)

        try:
            os.symlink(src, dst)
            f.success("✓ linking {src} ==> {dst}".format(src=src, dst=dst))
        except OSError as e:
            if e.errno == errno.EEXIST:
                f.warn("{src} ==> {dst} already exists".format(src=src, dst=dst))
                if query_yes_no("Do you want to overwrite the conflicting file?"):
                    if os.path.isdir(dst):
                        shutil.rmtree(dst)
                    else:
                        os.remove(dst)
                    os.symlink(src, dst)

def query_yes_no(question, default="yes"):
    """Ask a yes/no question via raw_input() and return their answer.

    "question" is a string that is presented to the user.
    "default" is the presumed answer if the user just hits <Enter>.
        It must be "yes" (the default), "no" or None (meaning
        an answer is required of the user).

    The "answer" return value is True for "yes" or False for "no".
    """
    valid = {"yes": True, "y": True, "ye": True,
            "no": False, "n": False}
    if default is None:
        prompt = " [y/n] "
    elif default == "yes":
        prompt = " [Y/n] "
    elif default == "no":
        prompt = " [y/N] "
    else:
        raise ValueError("invalid default answer: '%s'" % default)

    while True:
        sys.stdout.write(question + prompt)
        choice = input().lower()
        if default is not None and choice == '':
            return valid[default]
        elif choice in valid:
            return valid[choice]
        else:
            sys.stdout.write("Please respond with 'yes' or 'no' "
                    "(or 'y' or 'n').\n")

def test():
    for x in DOT_HOME_FILES:
        f.success("✓ %s" % os.path.join(HOME, x))
        assert os.path.exists(os.path.join(HOME, x))
    f.success("✓ All test passed")


def install():
    f.info("==> Start install progress...")
    f.info("==> Clone repository from GitHub")
    if os.path.exists(DOTFILES):
        f.success("✓ Skip to clone repository since it has been existed")
    else:
        if downloading_dotfiles() is False:
            f.fail("✗ Download failed. Please check your internet connection")
            sys.exit(1)
    f.success("✓ Finished to clone repository")
    if query_yes_no("Do you want to install dependencies?"):
        f.info("==> Installing requirements")
        if not install_required():
            f.fail("✗ Could not install requirements")
            sys.exit(1)
        f.success("✓ Finished installing requirements")
    if not has_required():
        f.fail("✗ Please install requirements first!")
        sys.exit(1)
    f.info("==> Start to deploy")
    if deploy() is False:
        f.fail("✗ Deploying failed.")
        sys.exit(1)
    f.success("✓ Finished to deploy")
    f.info("==> Installing Extras")
    if not install_extras():
        f.fail("✗ Could not install extras")
        sys.exit(1)
    f.info("==> Start to test")
    test()


def main():
    description = """
    The setup script for me. Linux and Mac OSX supports.

    Copyright (C) 2015 Ryosuke SATO (jtwp470)
    This software is released under the MIT License.

    Please refer to http://jtwp470.mit-license.org to know this license.
    """
    install()


if __name__ == "__main__":
    if len(sys.argv) != 2:
        # オプションがないときはall扱いする
        sys.argv.append("all")
    main()
