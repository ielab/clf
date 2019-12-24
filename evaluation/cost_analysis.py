# Import everything as needed.
import matplotlib as mpl
import pandas as pd
import seaborn as sns
import json

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
with open("rm2017comb/clf+weighting_2017.run.eval.json", "r") as f:
    original_2017 = pd.DataFrame(json.load(f)).T["NumRet"].median()
with open("rm2017comb/clf_rm_0.4_2017.run.eval.json", "r") as f:
    clf_2017 = pd.DataFrame(json.load(f)).T["NumRet"].median()
with open("rm2018comb/clf+weighting_2018.run.eval.json", "r") as f:
    original_2018 = pd.DataFrame(json.load(f)).T["NumRet"].median()
with open("rm2018comb/clf_rm_0.4_2018.run.eval.json", "r") as f:
    clf_2018 = pd.DataFrame(json.load(f)).T["NumRet"].median()


# %%
def cost_analysis(r1, r2):
    minutes_to_screen = 2.0
    pound_to_dollar = 1.83
    cost_per_min = 1.175 * pound_to_dollar
    return (r2 - r1) * minutes_to_screen * cost_per_min


# %%
cost_analysis(clf_2017, original_2017)
# %%
cost_analysis(clf_2018, original_2018)
# %%
# %%
