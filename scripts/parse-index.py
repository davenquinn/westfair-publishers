#!/usr/bin/env python3

import IPython
from sys import argv
from pandas import read_excel
from json import dumps

df = read_excel(argv[1], engine="openpyxl")

# Create first name component
df["Start"] = df["First"]

# Add nick name if present
has_nn = ~df["Nick name"].isna()
df.loc[has_nn,"Start"] += " " + df.loc[has_nn, "Nick name"]

# Add middle if present
has_middle = ~df["M"].isna()
df.loc[has_middle,"Start"] += " " + df.loc[has_middle, "M"] + "."

df = df.loc[:, ["Start","LAST"]]

df.rename(columns={"Start": "first", "LAST": "last"}, inplace=True)

print(dumps(df.values.tolist()))
