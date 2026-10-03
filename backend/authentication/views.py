from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import status
from .serilization import SignUpSeralization,LoginSerialization
from rest_framework.decorators import api_view
# Create your views here.
@api_view(["Post"])
def signup(request):
   print("start signup")
   serilizer= SignUpSeralization(data=request.data)

   if serilizer.is_valid():
      serilizer.save()
      return Response({"message":"SignUp suceesfully"},
                   status=status.HTTP_201_CREATED
                 )  

   return Response({"message":"SignUp Unsuceesfully","errors": serilizer.errors},
                   status=status.HTTP_400_BAD_REQUEST
                    )  

@api_view(["Post"])
def login(request):
   serializer=LoginSerialization(data=request.data)

   if serializer.is_valid():
      return Response({

         "message":"Login Sucessfully",
         "email":serializer.validated_data["email"],
         "access":serializer.validated_data["access"],
         "refresh":serializer.validated_data["refresh"],},status=status.HTTP_200_OK)
   
   return Response({"message":"Login faiL","error":serializer.errors}, status=status.HTTP_401_UNAUTHORIZED)

