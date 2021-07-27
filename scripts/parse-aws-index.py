#!/usr/bin/env python3

from sys import argv
from pandas import read_excel, isna
from json import dumps

df = read_excel(argv[1], engine="openpyxl")

# Create first name component
df["Start"] = df["First"]

# Add nick name if present
has_nn = ~df["Nick name"].isna()
df.loc[has_nn,"Start"] += " " + df.loc[has_nn, "Nick name"]

df["M"] = df["M"].str.replace(".", "")

last_item = ""
for ix, val in df["LAST"].iteritems():
    if not isna(val):
        last_item = val
    df.loc[ix,"LAST"] = last_item

df = df[~df["First"].isna()]

# Add middle if present
has_middle = ~df["M"].isna()
df.loc[has_middle,"Start"] += " " + df.loc[has_middle, "M"] + "."

df = df.loc[:, ["Start","LAST"]]

df.rename(columns={"Start": "first", "LAST": "last"}, inplace=True)

print(dumps(df.values.tolist()))
