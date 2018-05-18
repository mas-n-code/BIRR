# PythonLikertScale
# v0.1 (Aug 03 2017)
# Made by Mario Solis
# -------------------------------
# Will generate a likert scale based on volunteer feedback
#
#

import pandas as pd  # Statistical tool? Data analysis library
import matplotlib.pyplot as plt         # The plotting library
import numpy as np    # Number and math library

# import matplotlib as mpl
# import matplotlib.ticker as ticker
# import datetime

v_data = (0.5, 0.2, 0.3, 0.4)
rand_data = np.random.rand(4, 4)
raw_data1 = {'Questions': ['Q1', 'Q2', 'Q3',  'Q4'],
            'VPositive': [2, 24, 31, 3],
            'Positive': [1, 94, 57, 70],
            'Neutral': [2, 43, 23, 51],
            'Bad': [0, 43, 23, 51],
            'VBad': [6, 3, 23, 23]}

# v_responses = pd.DataFrame(np.random.rand(10, 4), columns=['a', 'b', 'c', 'd'])
v_responses_dataF = pd.DataFrame(raw_data1, columns=['Question', 'VPositive', 'Positive', 'Neutral', 'Bad', 'VBad'])
v_responses_dataF
v_responses_dataF.plot.barh(stacked=True)

# -------

# --- Creae dataframe ---
raw_data2 = {'first_name': ['Comfort', 'Comfort After', 'Tina', 'Jake', 'Amy'],
            'Score_1': [2, 24, 31, 2, 3],
            'Score_2': [1, 94, 57, 62, 70],
            'Score_3': [2, 43, 23, 23, 51],
            'Score_4': [0, 43, 23, 23, 51],
            'Score_5': [6, 3, 23, 23, 51]}
data_frame = pd.DataFrame(raw_data2, columns=['first_name', 'Score_1', 'Score_2', 'Score_3', 'Score_4', 'Score_5'])

# show the data_frame stuff
data_frame

# Create the general blog and the "subplots" i.e. the bars
f, ax1 = plt.subplots(1, figsize=(10,5))

# Set the bar width
bar_width = 0.75

# positions of the left bar-boundaries
bar_l = [i + 1 for i in range(len(data_frame['Score_1']))]

# positions of the x-axis ticks (center of the bars as bar labels)
tick_pos = [i+(bar_width/2) - 0.375 for i in bar_l]

# Create a bar plot, in position bar_1
ax1.bar(bar_l,
        # using the Score_1 data
        data_frame['Score_1'],
        # set the width
        width=bar_width,
        # with the label pre score
        label='Scores of 1',
        # with alpha 0.5
        alpha=0.5,
        # with color
        color='#F4561D')

# Create a bar plot, in position bar_1
ax1.bar(bar_l,
        # using the mid_score data
        data_frame['Score_2'],
        # set the width
        width=bar_width,
        # with Score_1 on the bottom
        bottom=data_frame['Score_1'],
        # with the label mid score
        label='Score of 2',
        # with alpha 0.5
        alpha=0.5,
        # with color
        color='#F1911E')

# Create a bar plot, in position bar_1
ax1.bar(bar_l,
        # using the post_score data
        data_frame['Score_3'],
        # set the width
        width=bar_width,
        # with Score_1 and mid_score on the bottom
        bottom=[i + j for i,j in zip(data_frame['Score_1'], data_frame['Score_2'])],
        # with the label post score
        label='Score of 3',
        # with alpha 0.5
        alpha=0.5,
        # with color
        color='#F1BD1A')

# set the x ticks with names
plt.xticks(tick_pos, data_frame['first_name'])

# Set the label and legends
ax1.set_ylabel("Total Score")
ax1.set_xlabel("Test Subject")
plt.legend(loc='upper left')

# Set a buffer around the edge
plt.xlim([min(tick_pos)-bar_width, max(tick_pos)+bar_width])
