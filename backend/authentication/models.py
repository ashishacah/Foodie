from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    email=models.EmailField(unique=True)
    phonenumber=models.CharField(max_length=100, blank=True,null=True)
    address=models.CharField(max_length=100,blank=True,null=True)
    profile_image=models.CharField(max_length=100,blank=True,null=True)


    def __str__(self):
        return self.username
  


