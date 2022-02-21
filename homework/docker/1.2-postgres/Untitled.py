#!/usr/bin/env python
# coding: utf-8

# In[7]:


import pandas as pd


# In[8]:


pd.__version__


# In[9]:


df = pd.read_csv('yellow_tripdata_2021-01.csv', nrows=100)


# In[10]:


df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)


# In[11]:


from sqlalchemy import create_engine


# In[12]:


engine = create_engine('postgresql://root:root@localhost:5432/ny_taxi')


# In[13]:


engine.connect()


# In[15]:


print(pd.io.sql.get_schema(df, name='yellow_taxi_data', con=engine))


# In[16]:


df_iter = pd.read_csv('yellow_tripdata_2021-01.csv', iterator=True, chunksize=100000)


# In[17]:


df = next(df_iter)


# In[18]:


len(df)


# In[19]:


df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)


# In[22]:


df.head(n=0).to_sql(name='yellow_taxi_data', con=engine, if_exists='replace')


# In[23]:


get_ipython().run_line_magic('time', "df.to_sql(name='yellow_taxi_data', con=engine, if_exists='replace')")


# In[24]:


from time import time


# In[26]:


while True:
    t_start = time()
    
    df = next(df_iter)
    
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
                                             
    df.to_sql(name='yellow_taxi_data', con=engine, if_exists='append')
                                             
    t_end = time()
                                             
    print('inserted another chunk, took %.3f second' % (t_end - t_start))


# In[ ]:




