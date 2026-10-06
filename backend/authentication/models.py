from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    ROLE_CHOICES = [
        ("Admin", "Admin"),
        ("Client", "Client"),
        ("Delivery-patner", "Delivery_patner"),
        ("Customer","Customer")
    ]
    role =models.CharField(max_length=20,choices=ROLE_CHOICES,default="Customer")
    email=models.EmailField(unique=True)

    phonenumber=models.CharField(max_length=100, blank=True,null=True)
    address=models.CharField(max_length=100,blank=True,null=True)
    profile_image=models.CharField(max_length=100,blank=True,null=True)

    USERNAME_FIELD="email"
    REQUIRED_FIELDS=["username"]
    def __str__(self):
        return self.username
  


