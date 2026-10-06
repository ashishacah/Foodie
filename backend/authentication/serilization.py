from .models import User
from rest_framework import serializers
from django.contrib.auth import authenticate
from rest_framework_simplejwt.tokens import RefreshToken

class SignUpSeralization (serializers.ModelSerializer):
    class Meta:
        model=User
        fields=["id", 
                "username",
                "email",
                "password",
                "role",
                "phonenumber",
                "address",
                "profile_image"]
        extra_kwargs={
            "password":{"write_only":True}
        }

    def create( self, validated_data):
            user=User.objects.create_user(
                username=validated_data["username"],
                email=validated_data["email"],
                password=validated_data["password"],
                role=validated_data.get("role",""),
                phonenumber=validated_data.get("phonenumber",""),
                address=validated_data.get("address",""),
                profile_image=validated_data.get("profile_image",""),
                
                  

    
             )
            return user

class LoginSerialization(serializers.Serializer):
    email=serializers.EmailField()
    password=serializers.CharField(write_only=True)



    def  validate(self, data):
        email=data.get("email")
        password=data.get("password")
        user=authenticate(
            username=email,
            password=password,
        )
        if user is None:
            raise serializers.ValidationError(
                "Invalid email or password"
            )
        refresh = RefreshToken.for_user(user)

        return {
            "role":user.role,
            "email":user.email,
            "access":str(refresh.access_token),
            "refresh":str(refresh),
            
        }
                        