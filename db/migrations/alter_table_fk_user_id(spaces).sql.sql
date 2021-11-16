ALTER TABLE public.spaces ADD CONSTRAINT spaces_fk FOREIGN KEY (fk_user) REFERENCES public.users(id);
