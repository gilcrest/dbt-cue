cue vet schema.cue src_stripe.cue
cue fmt schema.cue src_stripe.cue
cue export schema.cue src_stripe.cue --force --out yaml --outfile _stripe__sources.yml
