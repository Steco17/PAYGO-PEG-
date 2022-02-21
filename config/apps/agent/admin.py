from tabnanny import verbose
from django.contrib import admin
from django.contrib.auth.models import User
from .models import Agent
# Register your models here.

class AgentInLine(admin.StackedInline):
    model = Agent

class UserAdmin(admin.ModelAdmin):
    fields = ['username', 'password']
    inlines = [AgentInLine]


# Register your models here.
admin.site.register(User, UserAdmin)