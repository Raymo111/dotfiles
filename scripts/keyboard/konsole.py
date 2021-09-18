#!/usr/bin/python3
import polychromatic.profiles as prof
import openrazer.client
a = openrazer.client.DeviceManager().devices[0]   # Assumes keyboard is only device
b = prof.AppProfiles()
b.send_profile_from_file(a, '1594168353895366')
