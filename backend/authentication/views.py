from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import status
from .serilization import SignUpSeralization 
from rest_framework.decorators import api_view
# Create your views here.
@api_view(["Post"])
def signup(request):
   print("start signup")
   serilizer= SignUpSeralization(data=request.data)

   if serilizer.is_valid():
      print("valid data")
      return Response({"message":"SignUp suceesfully"},
                   status=status.HTTP_201_CREATED
                 )  

   return Response({"message":"SignUp Unsuceesfully","errors": serilizer.errors},
                   status=status.HTTP_400_BAD_REQUEST
                   
                 )  
def login(request):
   return Response({"message":"logged in"}, status=status.HTTP_200_Ok)

