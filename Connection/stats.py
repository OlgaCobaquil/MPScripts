from pydub import AudioSegment
from pydub.utils import make_chunks

#Get RMS of a wav
def rms(sound):
	rms_result= sound.dBFS
	return round(rms_result,2)

def pk_level(sound_in):
    db = sound_in.max_dBFS
    return round(db,2)

def crest(peak, rms):
	return peak/rms

def max_level(sound):
	max_lev = sound.get_dc_offset()
	return max_lev

sound = AudioSegment.from_file('E011 p1 M.wav', format="wav")

pk = pk_level(sound)
rms = rms(sound)
crest = crest(pk,rms)
max_level = max_level(sound)
print(pk)
print(rms)
print(crest)
print(max_level)