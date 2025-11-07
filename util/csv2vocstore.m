function out = csv2vocstore(csvfile,audiofile)
    vocStore = {};
    
    [aud,fs] = audioread(audiofile);

    fspl = split(csvfile,"/");
    filename = split(fspl(end),".");
    filename = filename(1);

    csv = readtable(csvfile);
    for i = 1:size(csv,1)
        start_s = csv.xmin(i);
        stop_s = csv.xmax(i);
        
        start_ix = round(start_s*fs);
        stop_ix = round(stop_s*fs);


        vocStore{i} = aud(start_ix:stop_ix);
    end

    % I know this is bad code but forgive me, I do things that work. Not
    % things that are efficient and work. Thats too much to ask.
    startIX = round(csv.xmin*fs);
    stopIX = round(csv.xmax*fs);
    save(filename+".mat","vocStore","startIX","stopIX");
end