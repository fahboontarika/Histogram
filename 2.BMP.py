
# coding: utf-8

# In[1]:


# import
import cv2
import numpy as np
import matplotlib.pyplot as plt

img = cv2.imread('bmp.bmp',0)

# histogram
#hist = cv2.calcHist([img],[0],None,[256],[0,256])
hist,bins = np.histogram(img.flatten(),256,[0,256])


# In[2]:


print(hist)
plt.plot(hist)
plt.show()


# In[3]:


# cdf
cdf = hist.cumsum()
cdf_normalized = cdf * hist.max()/ cdf.max()
plt.plot(cdf_normalized, color = 'r')
#print(cdf)


# In[4]:


# equalization
img_eq = cv2.equalizeHist(img)
hist_eq = cv2.calcHist([img_eq],[0],None,[256],[0,256])
cdf2 = hist_eq.cumsum()
cdf_normalized2 = cdf2 * hist_eq.max()/ cdf2.max()
plt.plot(cdf_normalized2, color = 'g')

plt.imshow(img,'gray')
plt.show()
plt.imshow(img_eq,'gray')
plt.show()


# In[5]:


plt.plot(hist)
plt.show()
#print(hist_eq)
plt.plot(hist_eq,'g')
plt.show()


# In[6]:


plt.plot(cdf_normalized, color = 'b')
plt.show()
plt.plot(cdf_normalized2, color = 'g')
plt.show()

