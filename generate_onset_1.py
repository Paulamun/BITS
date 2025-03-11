import os
import numpy as np
import pandas as pd
from glob import glob
from os.path import basename, dirname, isdir, isfile, join
import re



# def make_block_design(df):
#     trial = None
#     rows = list()
#     for i, row in df.iterrows():
#         if trial is None or trial != row["trial"]:
#             trial = row["trial"]
#             rows.append({"trial": trial, "ons": row["ons"]})
#     return pd.DataFrame(rows)

# def block_mid(df):
#     # FIXME: I'm guessing the Fixation.OnsetTime is the start of the
#     # consumption period.  Looking at PsychoPy files, the consumption
#     # period starts around 6 seconds after the anticipation period starts
#     dfs = dict()
#     for trial in df["trial"].unique():
#         tmp = df[df["trial"] == trial]
#         a = tmp[["Anticipate.OnsetTime"]]
#         a.columns = ["ons"]
#         a.loc[:, "dur"] = tmp["AntipDur"].astype(int) / 1000
#         dfs[f"{trial}_anticipation"] = a
#
#         c = tmp[["Fixation.OnsetTime"]]
#         c.columns = ["ons"]
#         c.loc[:, "dur"] = 2 # FIXME: this is approximately what the duration is, can't find column with this info
#         dfs[f"{trial}_consumption"]  = c
#     return dfs

# def format_mid(filepath):
#     df = parse_eprime(filepath, utf=8)
#     cue_map = {"Cir.bmp": "win_0", "Cir3.bmp": "win_5", "Sqr.bmp": "lose_0", "Sqr3.bmp": "lose_5"}
#     start = df["CountScreen.OnsetTime"].astype(float).min()
#     df = df[df["Procedure"] == "TrialProc"]
#     df["trial"] = df["CuePic"].map(cue_map)
#     for c in ["Anticipate.OnsetTime", "Fixation.OnsetTime"]:
#         df.loc[:, c] = ((df[c].astype(int) - start) / 1000) - 6 - 1.5 # seconds of dummy scans + blank screen
#     dfs = block_mid(df)
#     return dfs

# def format_gonogo(fp):
#     df = parse_eprime(fp)
#     def determine_trial(x):
#         return {"red": "nogo", "lime": "go"}[x.strip()]
#     df["trial"] = df["Color"].map(determine_trial)
#
#     df.replace("", np.nan, inplace=True)
#     for c in df:
#         if c not in ["trial", "Color", "Procedure", "Running"]:
#             df[c] = df[c].astype(float)
#
#     df["ons"] = (df["StimuliT.OnsetTime"] - df["StimuliT.OnsetTime"].min()) / 1000
#     df["trial_num"] = df["GoNoGoTest"].astype(int)
#     df = df[["trial_num", "trial", "ons"]]
#     return {
#         "nogo": df[df["trial"] == "nogo"],
#         "go": df[df["trial"] == "go"],
#     }

#def format_simon(fp, subject, shift_onset):
#   df = pd.read_excel(fp, header=None)
    # remove unwanted contents from the top rows
#    row_start = df[df.loc[:, 2].notna()].index[0]
#    df = df.iloc[row_start:, :].reset_index(drop=True)
#    df.columns = df.iloc[0]
#    df = df.drop(0).reset_index(drop=True)
#    # if not 55 trials throw an error message
#    if len(df)!= 55:
#        print(f"\nError: {fp} doesn't have the correct trial numbers!")
#        return
#    if "t" in df["Stimulus.RESP"]:
#        print(f"\nError: {fp} has response 't'!")
#        return
    # check for df["Subject"] to make sure it's the subject's eprime data
#    if str(df.Subject[0]) not in re.findall(r'\d+', subject)[0]:
#        print(f"\nError: {fp} is not the e-prime file for {subject}")
#        return
    # remove blank trials as they are not modelled at all
#    blank_trials = df[df['Blank'] == 1].index
#    df = df.drop(blank_trials).reset_index(drop=True)
#    if len(df)!= 44:
#        print(f"\nError: {fp} doesn't have the correct non-blank trial numbers!")
#        return
    # modify response: 2->1, 3->2
#    if 3 in df["Stimulus.RESP"]:
#        df.loc[df["Stimulus.RESP"] == 2, "Stimulus.RESP"] = 1
#        df.loc[df["Stimulus.RESP"] == 3, "Stimulus.RESP"] = 2
    # modify accuracy for subjects with backwards instructions
#    backwards_subject_s0 = ["MKET002", "MKET008", "MKET009", "MKET012", "MKET014", "MKET015", "MKET016"]
#    if subject in backwards_subject_s0:
        # modify stimulation types for backwards instructed subjects
#        df[['IncongruentListLeft', 'IncongruentListRight', 'CongruentListLeft', 'CongruentListRight']] \
#            = df[['CongruentListRight', 'CongruentListLeft', 'IncongruentListRight', 'IncongruentListLeft']]
        # modify accuracy accordingly
#        df["Stimulus.RESP"] = 3 - df["Stimulus.RESP"]
    # modify accuracy for subjects with updated response
#    df.loc[df['CorrectAnswer'] == df["Stimulus.RESP"], 'Stimulus.ACC'] = 1
#    df.loc[df['CorrectAnswer'] != df["Stimulus.RESP"], 'Stimulus.ACC'] = 0
    # summarize incongruent and congruent trials
#    df['IncongruentList'] = df.loc[:, ['IncongruentListLeft', 'IncongruentListRight']].sum(axis=1, min_count=1)
#    df['CongruentList'] = df.loc[:, ['CongruentListLeft', 'CongruentListRight']].sum(axis=1, min_count=1)
#    df.loc[df['IncongruentList'] == 1, 'StimVar'] = 'Incongruent'
#    df.loc[df['CongruentList'] == 1, 'StimVar'] = 'Congruent'

    # generate preceding incongruent and congruent trials
#    df['IncongruentPriorList'] = (df['IncongruentList']).shift(1, axis=0)
#    df['CongruentPriorList'] = (df['CongruentList']).shift(1, axis=0)

    # generate trial types for modeling
    # 1. CORRECT congruent preceded by congruent (cC)
#    cC = df[(df['Stimulus.ACC'] == 1) & (df['CongruentList'] == 1) & (df['CongruentPriorList'] == 1)].index
#    df.loc[cC, 'trial_type'] = 'cC'
    # 2. CORRECT congruent preceded by incongruent (iC)
#    iC = df[(df['Stimulus.ACC'] == 1) & (df['CongruentList'] == 1) & (df['IncongruentPriorList'] == 1)].index
#    df.loc[iC, 'trial_type'] = 'iC'
    # 3. CORRECT incongruent preceded by congruent (cI)
#    cI = df[(df['Stimulus.ACC'] == 1) & (df['IncongruentList'] == 1) & (df['CongruentPriorList'] == 1)].index
#    df.loc[cI, 'trial_type'] = 'cI'
    # 4. CORRECT incongruent preceded by incongruent (iI)
#    iI = df[(df['Stimulus.ACC'] == 1) & (df['IncongruentList'] == 1) & (df['IncongruentPriorList'] == 1)].index
#    df.loc[iI, 'trial_type'] = 'iI'
    # 5. All incorrect
#    df.loc[((df['Stimulus.ACC'] == 0) | ((df['Stimulus.RT'] > 0) & (df['Stimulus.RT'] < 200))), 'trial_type'] = 'aI'
    # 6. first trial
#    df.loc[0, 'trial_type'] = 'ft'

    # rename columns in df
#    df['onset'] = df['NewStimOnsetTime']/1000.0 - shift_onset
#    df['duration'] = df['Stimulus.Duration']/1000.0
#    df['response_time'] = df['Stimulus.RT']/1000.0
#    df['trial_num'] = df['Trial']
#    df['correctness'] = df['Stimulus.ACC']
#    dfs = df[["onset", "duration", "trial_type", "response_time", "correctness", "StimVar", "trial_num"]]
    # check if nan exists
#    if dfs.isnull().values.any():
#        print(f"\nError: {fp} has trials which can not be recognized correctly!")
#        return
#    return dfs



def format_gonogo(fp, subject, shift_onset):
    df = pd.read_excel(fp, header=None)
    # remove unwanted contents from the top rows
    row_start = df[df.loc[:, 2].notna()].index[0]
    df = df.iloc[row_start:, :].reset_index(drop=True)
    df.columns = df.iloc[0]
    df = df.drop(0).reset_index(drop=True)
    # if not 55 trials throw an error message
    if len(df) != 240:
        print(f"\nError: {fp} doesn't have the correct trial numbers!")
        return
    # check for df["Subject"] to make sure it's the subject's eprime data
    if str(df.Subject[0]) not in re.findall(r'\d+', subject)[0]:
        print(f"\nError: {fp} is not the e-prime file for {subject}!")
        return

    if 'StimuliT.RESP' not in df.columns:
        print(f"\nError: {fp} is from a different eprime task!")
        return
    #     df['StimuliT.RESP'] = df['StimDisp.RESP']
    #     df['StimuliT.RT'] = df['StimDisp.RT']
    #     df['StimuliT.ACC'] = df['StimDisp.ACC']
    #     df['IntroText.RTTime'] = df['Fixation.OnsetTime']
    if "t" in df["StimuliT.RESP"]:
        print(f"\nError: {fp} has response 't'!")
        return
    # modify accuracy for subjects
    df["StimuliT.RESP"] = df["StimuliT.RESP"].fillna(0)
    df['CorrectResponse'] = df['CorrectResponse'].fillna(0)
    df.loc[df['CorrectResponse'] == df["StimuliT.RESP"], 'StimuliT.ACC'] = 1
    df.loc[df['CorrectResponse'] != df["StimuliT.RESP"], 'StimuliT.ACC'] = 0
    # if RT < 100ms then incorrect
    df.loc[((df['StimuliT.RT'] < 100) & (df["StimuliT.RESP"] == 1)), 'StimuliT.ACC'] = 0
    # 1. CORRECT Go trials
    cGo = df[(df['StimuliT.ACC'] == 1) & (df['CorrectResponse'] == 1)].index
    df.loc[cGo, 'trial_type'] = 'cGo'
    # 2. INCORRECT Go trials
    iGo = df[(df['StimuliT.ACC'] == 0) & (df['CorrectResponse'] == 1)].index
    df.loc[iGo, 'trial_type'] = 'iGo'
    # 3. CORRECT NoGo trials
    cNoGo = df[(df['StimuliT.ACC'] == 1) & (df['CorrectResponse'] != 1)].index
    df.loc[cNoGo, 'trial_type'] = 'cNoGo'
    # 4. INCORRECT NoGo
    iNoGo = df[(df['StimuliT.ACC'] == 0) & (df['CorrectResponse'] != 1)].index
    df.loc[iNoGo, 'trial_type'] = 'iNoGo'

    # rename columns in df
    df['onset'] = (df['StimuliT.OnsetTime'] - df['IntroText.RTTime']) / 1000.0 - shift_onset
    df['duration'] = df['StimuliT.OnsetToOnsetTime'] / 1000.0
    df['response_time'] = df['StimuliT.RT'] / 1000.0
    df['trial_num'] = df['Block']
    df['correctness'] = df['StimuliT.ACC']
    df.loc[df['CorrectResponse'] == 1, 'StimVar'] = 'Go'
    df.loc[df['CorrectResponse'] == 0, 'StimVar'] = 'NoGo'
    dfs = df[["onset", "duration", "trial_type", "response_time", "correctness", "StimVar", "trial_num"]]

    # check if nan exists
    if dfs.isnull().values.any():
        print(f"\nError: {fp} has trials which can not be recognized correctly!")
        return
    return dfs

# AP - Adding one for when the format is already tsv
def format_gonogotsv(fp, subject, shift_onset):
    df = pd.read_csv(fp,sep='\t',header=0)
    # remove unwanted contents from the top rows
    # AP - commented out below, as these appear to be gone already in tsvs (rather than xlsx)
    # row_start = df[df.loc[:, 2].notna()].index[0]
    #df = df.iloc[row_start:, :].reset_index(drop=True)
    #df.columns = df.iloc[0]
    #df = df.drop(0).reset_index(drop=True)
    # if not 55 trials throw an error message
    if len(df) != 240:
        print(f"\nError: {fp} doesn't have the correct trial numbers!")
        return
    # check for df["Subject"] to make sure it's the subject's eprime data
    if str(df.Subject[0]) not in re.findall(r'\d+', subject)[0]:
        print(f"\nError: {fp} is not the e-prime file for {subject}!")
        return
    if 'StimuliT.RESP' not in df.columns:
        print(f"\nError: {fp} is from a different eprime task!")
        return
    #     df['StimuliT.RESP'] = df['StimDisp.RESP']
    #     df['StimuliT.RT'] = df['StimDisp.RT']
    #     df['StimuliT.ACC'] = df['StimDisp.ACC']
    #     df['IntroText.RTTime'] = df['Fixation.OnsetTime']
    if "t" in df["StimuliT.RESP"]:
        print(f"\nError: {fp} has response 't'!")
        return
    # modify accuracy for subjects
    df["StimuliT.RESP"] = df["StimuliT.RESP"].fillna(0)
    df['CorrectResponse'] = df['CorrectResponse'].fillna(0)
    df.loc[df['CorrectResponse'] == df["StimuliT.RESP"], 'StimuliT.ACC'] = 1
    df.loc[df['CorrectResponse'] != df["StimuliT.RESP"], 'StimuliT.ACC'] = 0
    # if RT < 100ms then incorrect
    df.loc[((df['StimuliT.RT'] < 100) & (df["StimuliT.RESP"] == 1)), 'StimuliT.ACC'] = 0
    # 1. CORRECT Go trials
    cGo = df[(df['StimuliT.ACC'] == 1) & (df['CorrectResponse'] == 1)].index
    df.loc[cGo, 'trial_type'] = 'cGo'
    # 2. INCORRECT Go trials
    iGo = df[(df['StimuliT.ACC'] == 0) & (df['CorrectResponse'] == 1)].index
    df.loc[iGo, 'trial_type'] = 'iGo'
    # 3. CORRECT NoGo trials
    cNoGo = df[(df['StimuliT.ACC'] == 1) & (df['CorrectResponse'] != 1)].index
    df.loc[cNoGo, 'trial_type'] = 'cNoGo'
    # 4. INCORRECT NoGo
    iNoGo = df[(df['StimuliT.ACC'] == 0) & (df['CorrectResponse'] != 1)].index
    df.loc[iNoGo, 'trial_type'] = 'iNoGo'

    # rename columns in df
    df['onset'] = (df['StimuliT.OnsetTime'] - df['IntroText.RTTime']) / 1000.0 - shift_onset
    df['duration'] = df['StimuliT.OnsetToOnsetTime'] / 1000.0
    df['response_time'] = df['StimuliT.RT'] / 1000.0
    df['trial_num'] = df['Block']
    df['correctness'] = df['StimuliT.ACC']
    df.loc[df['CorrectResponse'] == 1, 'StimVar'] = 'Go'
    df.loc[df['CorrectResponse'] == 0, 'StimVar'] = 'NoGo'
    dfs = df[["onset", "duration", "trial_type", "response_time", "correctness", "StimVar", "trial_num"]]

    # check if nan exists
    if dfs.isnull().values.any():
        print(f"\nError: {fp} has trials which can not be recognized correctly!")
        return
    return dfs


def format_mid(fp, subject, shift_onset):
    return


def format_oddball(fp, subject, shift_onset):
    return

def format_nonconscious(fp, subject, shift_onset):
    return

def format_lossaversion(fp, subject, shift_onset):
    return

def format_mia(fp, subject, shift_onset):
    return

def format_meid(fp, subject, shift_onset):
    return
