from .models import User
from rest_framework import serializers

class SignUpSeralization (serializers.ModelSerializer):
    class Meta:
        model=User
        fields=["id", 
                "username",
                "email",
                "password",
                "phonenumber",
                "address",
                "profile_image"]
        extra_kwargs={
            "password":{"write_only":True}
        }
