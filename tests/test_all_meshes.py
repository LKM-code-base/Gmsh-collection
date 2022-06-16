#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from generate_xdmf_mesh import *
import glob
import subprocess


def test_all_meshes():
    geo_files = glob.glob("./meshes/*.geo", recursive=True)
    geo_files += glob.glob("./../meshes/*.geo", recursive=True)
    for file in geo_files:
        generate_xdmf_mesh(file)
        subprocess.run(["rm", "-f", file.replace(".geo", ".msh")], check=True, stdout=subprocess.DEVNULL)
        subprocess.run(["rm", "-f", file.replace(".geo", ".xdmf")], check=True, stdout=subprocess.DEVNULL)
        facet_file = file[:file.index(".geo")] + "_facet_markers"
        subprocess.run(["rm", "-f", facet_file + ".xdmf"], check=True, stdout=subprocess.DEVNULL)


if __name__ == "__main__":
    test_all_meshes()
