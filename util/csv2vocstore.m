function csv2vocstore(csvfile,audiofile,output)
    %%%%%% Inputs 
            % csvfile[string,char]: Path to .CSV file containing vocalizations. Should
                        % have at least two columns - 
                        % "xmin" -> time start of vocalization in SECONDS
                        % "xmax" -> time stop of vocalization in SECONDS
            
            % audiofile[string,char]: Path to audio file. Should be MONO. 
            % output[string,char]: Path to output.
    if nargin < 3
        output = "";
    end
    
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

    if output == ""
        save(filename+".mat","vocStore","startIX","stopIX");
    else
        save(output,"vocStore","startIX","stopIX");
    end
end