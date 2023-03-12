"""
This is a file who simplifies some of the pandas functions 
"""

import pandas as pd



# methods
def read_csv(filename) -> pd.DataFrame:
    return pd.read_csv(filename)

def get_length(df) -> int:
    print(len(df))

def get_spec_data(df, col_name, search_word):
    return df.loc[df[str(col_name)] == str(search_word), :]

def col_names(df):
    return list(df.columns)