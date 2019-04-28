from config.settings_common import *

DEBUG = True
SECRET_KEY = 'secret'

INSTALLED_APPS += [
    'debug_toolbar',
]

DATABASES['default'].update({
    'NAME': 'mymdb',
    'USER': 'mymdb',
    'PASSWORD': 'development',
    'HOST': 'localhost',
    'PORT': '5432',
})

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
        'LOCATION': 'default-locmemcache',
        'TIMEOUT': 5, # 5 seconds
    }
}

MEDIA_ROOT = os.path.join(BASE_DIR, '../media_root')

INTERNAL_IPS = [
    # For Django Debug Toolbar
    '127.0.0.1',
]

