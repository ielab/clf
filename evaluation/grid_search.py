# Import everything as needed.
from collections import OrderedDict
from matplotlib import pyplot as plt
import matplotlib as mpl
import pandas as pd
import seaborn as sns
import json
import os
import operator
import numpy as np

from IPython.display import set_matplotlib_formats

set_matplotlib_formats('png')

# Set general plot properties.
sns.set()
sns.set_context("paper")
sns.set_color_codes("pastel")

pd.options.display.max_rows = 1000

# This causes matplotlib to use Type 42 (a.k.a. TrueType) fonts for PostScript and PDF files.
# This allows you to avoid Type 3 fonts without limiting yourself to the stone-age technology
# of Type 1 fonts.
mpl.rcParams['pdf.fonttype'] = 42
mpl.rcParams['ps.fonttype'] = 42

# %%

folder = ""
folder_2017 = "rm_grid_search_2017comb/" + folder
folder_2018 = "rm_grid_search_2018comb/" + folder

runs_2017 = OrderedDict()
runs_2018 = OrderedDict()

for file in os.listdir(folder_2017):
    print(file)
    r = file.replace("clf_rm_gain_2017_", "").replace("clf_rm_2017_").replace(".run.eval.json", "")
    with open(folder_2017 + file, "r") as f:
        runs_2017[float(r)] = json.load(f)

for file in os.listdir(folder_2018):
    print(file)
    r = file.replace("clf_rm_gain_2018_", "").replace("clf_rm_2018_").replace(".run.eval.json", "")
    with open(folder_2018 + file, "r") as f:
        runs_2018[float(r)] = json.load(f)

runs_2017 = dict(sorted(runs_2017.items(), key=operator.itemgetter(0)))
runs_2018 = dict(sorted(runs_2018.items(), key=operator.itemgetter(0)))

# %%

ds = runs_2017

sns.set()
sns.set_context({"figure.figsize": (5, 4)})
plt.style.use('grayscale')
plt.style.use('seaborn-white')
fig, ax = plt.subplots()
X = np.array([x for x in ds.keys()])
Y = np.array([pd.DataFrame(ds[k]).T["loss_er"].mean() for k in ds.keys()])

sns.lineplot(x=X, y=Y)
ax.set_ylabel("Reliability", fontsize=14)
ax.set_xlabel("$\kappa$", fontsize=14)
ax.set_ylim(0, 1)
plt.tight_layout()
plt.savefig("../figures/train_2017_gain.pdf")
plt.show()

# %%
ds = runs_2018

sns.set()
sns.set_context({"figure.figsize": (5, 4)})
plt.style.use('grayscale')
plt.style.use('seaborn-white')
fig, ax = plt.subplots()
X = np.array([x for x in ds.keys()])
Y = np.array([pd.DataFrame(ds[k]).T["loss_er"].mean() for k in ds.keys()])

sns.lineplot(x=X, y=Y)
ax.set_ylabel("Reliability", fontsize=14)
ax.set_xlabel("$\kappa$", fontsize=14)
ax.set_ylim(0, 1)
plt.tight_layout()
plt.savefig("../figures/train_2018_gain.pdf")
plt.show()
