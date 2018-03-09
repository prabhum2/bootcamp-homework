

```python
#import the necessary libraries
import os
import pandas as pd
import numpy as np
import json
```


```python
#construct the requried dataframes for the two json files
pcd = pd.read_json("../HeroesOfPymoli/purchase_data.json")
pcd.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Age</th>
      <th>Gender</th>
      <th>Item ID</th>
      <th>Item Name</th>
      <th>Price</th>
      <th>SN</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>38</td>
      <td>Male</td>
      <td>165</td>
      <td>Bone Crushing Silver Skewer</td>
      <td>3.37</td>
      <td>Aelalis34</td>
    </tr>
    <tr>
      <th>1</th>
      <td>21</td>
      <td>Male</td>
      <td>119</td>
      <td>Stormbringer, Dark Blade of Ending Misery</td>
      <td>2.32</td>
      <td>Eolo46</td>
    </tr>
    <tr>
      <th>2</th>
      <td>34</td>
      <td>Male</td>
      <td>174</td>
      <td>Primitive Blade</td>
      <td>2.46</td>
      <td>Assastnya25</td>
    </tr>
    <tr>
      <th>3</th>
      <td>21</td>
      <td>Male</td>
      <td>92</td>
      <td>Final Critic</td>
      <td>1.36</td>
      <td>Pheusrical25</td>
    </tr>
    <tr>
      <th>4</th>
      <td>23</td>
      <td>Male</td>
      <td>63</td>
      <td>Stormfury Mace</td>
      <td>1.27</td>
      <td>Aela59</td>
    </tr>
  </tbody>
</table>
</div>




```python
#shape of the dataframes
pcd.shape
```




    (780, 6)




```python
#datatypes of the dataframe
pcd.info()
```

    <class 'pandas.core.frame.DataFrame'>
    Int64Index: 780 entries, 0 to 779
    Data columns (total 6 columns):
    Age          780 non-null int64
    Gender       780 non-null object
    Item ID      780 non-null int64
    Item Name    780 non-null object
    Price        780 non-null float64
    SN           780 non-null object
    dtypes: float64(1), int64(2), object(3)
    memory usage: 42.7+ KB


======================================================================================================================

**Player Count**

* Total Number of Players


```python
# Total Number of Players
# pcd['SN'].nunique()

pcd.SN.value_counts().count()
```




    573




```python
pd.DataFrame({"Total Number of Players":pcd.SN.value_counts().count()},index=[0])
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Total Number of Players</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>573</td>
    </tr>
  </tbody>
</table>
</div>



======================================================================================================================

**Purchasing Analysis (Total)**

* Number of Unique Items
* Average Purchase Price
* Total Number of Purchases
* Total Revenue


```python
# Number of Unique Items
pcd['Item ID'].nunique()
```




    183




```python
# Average Purchase Price
pcd['Price'].mean()
```




    2.931192307692303




```python
# Total Number of Purchases
len(pcd)
```




    780




```python
# Total Revenue
pcd['Price'].sum()
```




    2286.3299999999963




```python
pd.DataFrame({"Number of Unique Items":pcd['Item ID'].nunique(),
  "Average Purchase Price":pcd['Price'].mean(),
 "Total Number of Purchases":len(pcd),
"Total Revenue":pcd['Price'].sum()},index=[0])
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Average Purchase Price</th>
      <th>Number of Unique Items</th>
      <th>Total Number of Purchases</th>
      <th>Total Revenue</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2.931192</td>
      <td>183</td>
      <td>780</td>
      <td>2286.33</td>
    </tr>
  </tbody>
</table>
</div>



======================================================================================================================

**Gender Demographics**

* Percentage and Count of Male Players
* Percentage and Count of Female Players
* Percentage and Count of Other / Non-Disclosed


```python
# get all the duplicate rows
print(df.loc[df.duplicated("SN",keep=False),:].sort_values("SN").head(10))
print(len(df.loc[df.duplicated("SN",keep=False),:]))
```

         Age Gender  Item ID                             Item Name  Price  \
    431   37   Male       92                          Final Critic   1.36   
    308   37   Male       79                   Alpha, Oath of Zeal   2.88   
    377   37   Male      174                       Primitive Blade   2.46   
    647   26   Male      156          Soul-Forged Steel Shortsword   1.16   
    721   26   Male       39  Betrayal, Whisper of Grieving Widows   2.35   
    224   26   Male      106                   Crying Steel Sickle   2.29   
    529   38   Male      172                    Blade of the Grave   1.69   
    0     38   Male      165           Bone Crushing Silver Skewer   3.37   
    359   20   Male       32                               Orenmir   4.95   
    637   20   Male       18            Torchlight, Bond of Storms   1.77   
    
                 SN  
    431  Aduephos78  
    308  Aduephos78  
    377  Aduephos78  
    647   Aeduera68  
    721   Aeduera68  
    224   Aeduera68  
    529   Aelalis34  
    0     Aelalis34  
    359  Aeliriam77  
    637  Aeliriam77  
    375



```python
# drop the duplicate SN rows to get gender propotions
pcd_unique = pcd.drop_duplicates("SN", keep='first')
len(pcd_unique)
```




    573




```python
pd.DataFrame({'Percentage of players' : pcd_unique['Gender'].value_counts(normalize=True),
   'Total Count' : pcd_unique['Gender'].value_counts()})
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Percentage of players</th>
      <th>Total Count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Male</th>
      <td>0.811518</td>
      <td>465</td>
    </tr>
    <tr>
      <th>Female</th>
      <td>0.174520</td>
      <td>100</td>
    </tr>
    <tr>
      <th>Other / Non-Disclosed</th>
      <td>0.013962</td>
      <td>8</td>
    </tr>
  </tbody>
</table>
</div>



======================================================================================================================

**Purchasing Analysis (Gender)** 

* The below each broken by gender
  * Purchase Count
  * Average Purchase Price
  * Total Purchase Value
  * Normalized Totals (purchase total and divide it by the total count)


```python
summary_gender_purchasing = pd.DataFrame(pcd.groupby('Gender').agg({'Price':[np.mean,np.sum],'Item ID':'count'}))
summary_gender_purchasing
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th></th>
      <th colspan="2" halign="left">Price</th>
      <th>Item ID</th>
    </tr>
    <tr>
      <th></th>
      <th>mean</th>
      <th>sum</th>
      <th>count</th>
    </tr>
    <tr>
      <th>Gender</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Female</th>
      <td>2.815515</td>
      <td>382.91</td>
      <td>136</td>
    </tr>
    <tr>
      <th>Male</th>
      <td>2.950521</td>
      <td>1867.68</td>
      <td>633</td>
    </tr>
    <tr>
      <th>Other / Non-Disclosed</th>
      <td>3.249091</td>
      <td>35.74</td>
      <td>11</td>
    </tr>
  </tbody>
</table>
</div>



======================================================================================================================

**Age Demographics**

* The below each broken into bins of 4 years (i.e. &lt;10, 10-14, 15-19, etc.) 
  * Purchase Count
  * Average Purchase Price
  * Total Purchase Value
  * Normalized Totals


```python
test = pd.DataFrame({'days': [0,31,45,60]})
test['range'] = pd.cut(test.days, [0,30,60,90], right=False)
test

# right : Indicates whether the bins include the rightmost edge or not. If
# right == True (the default), then the bins [1,2,3,4] indicate
# (1,2], (2,3], (3,4]
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>days</th>
      <th>range</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>[0, 30)</td>
    </tr>
    <tr>
      <th>1</th>
      <td>31</td>
      <td>[30, 60)</td>
    </tr>
    <tr>
      <th>2</th>
      <td>45</td>
      <td>[30, 60)</td>
    </tr>
    <tr>
      <th>3</th>
      <td>60</td>
      <td>[60, 90)</td>
    </tr>
  </tbody>
</table>
</div>




```python
age_bins = [0, 10, 15, 20, 25, 30, 35, 40, 100]
age_labels = ['<10', '10-14', '15-19', '20-24','25-29','30-34','35-39','40+']
pcd['Age_Group'] = pd.cut(pcd['Age'], age_bins ,labels = age_labels,right=False)
```


```python
summary_age = pd.DataFrame(pcd.groupby('Age_Group').agg({'Price':[np.mean,np.sum],'Item ID':'count'}))
```


```python
summary_age
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th></th>
      <th colspan="2" halign="left">Price</th>
      <th>Item ID</th>
    </tr>
    <tr>
      <th></th>
      <th>mean</th>
      <th>sum</th>
      <th>count</th>
    </tr>
    <tr>
      <th>Age_Group</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>10-14</th>
      <td>2.770000</td>
      <td>96.95</td>
      <td>35</td>
    </tr>
    <tr>
      <th>15-19</th>
      <td>2.905414</td>
      <td>386.42</td>
      <td>133</td>
    </tr>
    <tr>
      <th>20-24</th>
      <td>2.913006</td>
      <td>978.77</td>
      <td>336</td>
    </tr>
    <tr>
      <th>25-29</th>
      <td>2.962640</td>
      <td>370.33</td>
      <td>125</td>
    </tr>
    <tr>
      <th>30-34</th>
      <td>3.082031</td>
      <td>197.25</td>
      <td>64</td>
    </tr>
    <tr>
      <th>35-39</th>
      <td>2.842857</td>
      <td>119.40</td>
      <td>42</td>
    </tr>
    <tr>
      <th>40+</th>
      <td>3.161765</td>
      <td>53.75</td>
      <td>17</td>
    </tr>
    <tr>
      <th>&lt;10</th>
      <td>2.980714</td>
      <td>83.46</td>
      <td>28</td>
    </tr>
  </tbody>
</table>
</div>



======================================================================================================================

**Top Spenders**

* Identify the the top 5 spenders in the game by total purchase value, then list (in a table):
  * SN
  * Purchase Count
  * Average Purchase Price
  * Total Purchase Value


```python
summary_spenders = pd.DataFrame(pcd.groupby(['SN']).agg({'Price':[np.mean,np.sum],'Item ID':'count'}))
```


```python
summary_spenders.sort_values(('Price','sum'),ascending=False)[:5]
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th></th>
      <th colspan="2" halign="left">Price</th>
      <th>Item ID</th>
    </tr>
    <tr>
      <th></th>
      <th>mean</th>
      <th>sum</th>
      <th>count</th>
    </tr>
    <tr>
      <th>SN</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Undirrala66</th>
      <td>3.412000</td>
      <td>17.06</td>
      <td>5</td>
    </tr>
    <tr>
      <th>Saedue76</th>
      <td>3.390000</td>
      <td>13.56</td>
      <td>4</td>
    </tr>
    <tr>
      <th>Mindimnya67</th>
      <td>3.185000</td>
      <td>12.74</td>
      <td>4</td>
    </tr>
    <tr>
      <th>Haellysu29</th>
      <td>4.243333</td>
      <td>12.73</td>
      <td>3</td>
    </tr>
    <tr>
      <th>Eoda93</th>
      <td>3.860000</td>
      <td>11.58</td>
      <td>3</td>
    </tr>
  </tbody>
</table>
</div>



======================================================================================================================

**Most Popular Items**

* Identify the 5 most popular items by purchase count, then list (in a table):
  * Item ID
  * Item Name
  * Purchase Count
  * Item Price
  * Total Purchase Value


```python
summary_items = pd.DataFrame(pcd.groupby(['Item ID','Item Name']).agg({'Price':[np.mean,np.sum],'Item ID':'count'}))
```


```python
summary_items.sort_values(('Item ID','count'),ascending=False)[0:5]
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th></th>
      <th></th>
      <th colspan="2" halign="left">Price</th>
      <th>Item ID</th>
    </tr>
    <tr>
      <th></th>
      <th></th>
      <th>mean</th>
      <th>sum</th>
      <th>count</th>
    </tr>
    <tr>
      <th>Item ID</th>
      <th>Item Name</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>39</th>
      <th>Betrayal, Whisper of Grieving Widows</th>
      <td>2.35</td>
      <td>25.85</td>
      <td>11</td>
    </tr>
    <tr>
      <th>84</th>
      <th>Arcane Gem</th>
      <td>2.23</td>
      <td>24.53</td>
      <td>11</td>
    </tr>
    <tr>
      <th>31</th>
      <th>Trickster</th>
      <td>2.07</td>
      <td>18.63</td>
      <td>9</td>
    </tr>
    <tr>
      <th>175</th>
      <th>Woeful Adamantite Claymore</th>
      <td>1.24</td>
      <td>11.16</td>
      <td>9</td>
    </tr>
    <tr>
      <th>13</th>
      <th>Serenity</th>
      <td>1.49</td>
      <td>13.41</td>
      <td>9</td>
    </tr>
  </tbody>
</table>
</div>



======================================================================================================================

**Most Profitable Items**

* Identify the 5 most profitable items by total purchase value, then list (in a table):
  * Item ID
  * Item Name
  * Purchase Count
  * Item Price
  * Total Purchase Value


```python
summary_items = pd.DataFrame(pcd.groupby(['Item ID','Item Name']).agg({'Price':[np.mean,np.sum],'Item ID':'count'}))
```


```python
summary_items.sort_values(('Price','sum'),ascending=False)[0:5]
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th></th>
      <th></th>
      <th colspan="2" halign="left">Price</th>
      <th>Item ID</th>
    </tr>
    <tr>
      <th></th>
      <th></th>
      <th>mean</th>
      <th>sum</th>
      <th>count</th>
    </tr>
    <tr>
      <th>Item ID</th>
      <th>Item Name</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>34</th>
      <th>Retribution Axe</th>
      <td>4.14</td>
      <td>37.26</td>
      <td>9</td>
    </tr>
    <tr>
      <th>115</th>
      <th>Spectral Diamond Doomblade</th>
      <td>4.25</td>
      <td>29.75</td>
      <td>7</td>
    </tr>
    <tr>
      <th>32</th>
      <th>Orenmir</th>
      <td>4.95</td>
      <td>29.70</td>
      <td>6</td>
    </tr>
    <tr>
      <th>103</th>
      <th>Singed Scalpel</th>
      <td>4.87</td>
      <td>29.22</td>
      <td>6</td>
    </tr>
    <tr>
      <th>107</th>
      <th>Splitter, Foe Of Subtlety</th>
      <td>3.61</td>
      <td>28.88</td>
      <td>8</td>
    </tr>
  </tbody>
</table>
</div>



======================================================================================================================

### Observations

    As per the Game's purchasing data, Eighty-one percent of men made a purchase, compared to 17% of women indicating that the game is more popular among the male demographics. 

    Those consumers aged 20 to 24, remain the key age demographic for pymoli, spending more money than any other age group.
    
    Those consumers aged 40 and above remain the age group purchasing high value items.
