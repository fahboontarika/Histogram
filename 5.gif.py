
# coding: utf-8

# In[1]:


# import
import cv2
import numpy as np
import matplotlib.pyplot as plt
from skimage import io
from PIL import Image

img = Image.open('gif.gif').convert('LA')
img = io.imread("gif.gif",as_gray=True)

# histogram
hist = cv2.calcHist([img],[0],None,[256],[0,256])
#hist,bins = np.histogram(img.flatten(),256,[0,256])


# In[2]:


#print(hist)
plt.plot(hist)
plt.show()


# In[3]:


# cdf
cdf = hist.cumsum()
cdf_normalized = cdf * hist.max()/ cdf.max()
plt.plot(cdf_normalized, color = 'r')
#print(cdf)

