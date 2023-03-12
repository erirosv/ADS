import sys
import os
import datetime
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.dates as mdates

sys.path.append("..")
import utility.plot_settings

# exporting figures
def figure_export(filename) -> None:
    date = datetime.date.today().strftime("%d-%m-%Y")
    path = f"../../reports/figures/{date}/"
    if os.path.exists(path):
        plt.savefig(path + filename + ".png", bbox_inches="tight")
    if not os.path.exists(path):
        os.makedirs(path)
        plt.savefig(path + filename + ".png", bbox_inches="tight")
    print(f"Successfully export {filename}")