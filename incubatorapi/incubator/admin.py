from django.contrib import admin

from .models import Incubator, Laboratory, XRay, Medicine

admin.site.register(Incubator)
admin.site.register(Laboratory)
admin.site.register(XRay)
admin.site.register(Medicine)

# Register your models here.
