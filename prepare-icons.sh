curl https://d1.awsstatic.com/webteam/architecture-icons/q3-2022/Asset-Package_07312022.e9f969935ef6aa73b775f3a4cd8c67af2a4cf51e.zip --output ./aws-asset-package_07312022.zip;

replace_text_in_filename() {
  search="$1"
  replace="$2"

  find . -type f | while read file; do
    newname=$(echo "$file" | sed "s/$search/$replace/")
    if [ "$file" != "$newname" ]; then
      mv "$file" "$newname";
    fi
  done
};
replace_text_in_filename_g() {
  search="$1"
  replace="$2"

  find . -type f | while read file; do
    newname=$(echo "$file" | sed "s/$search/$replace/g")
    if [ "$file" != "$newname" ]; then
      mv "$file" "$newname";
    fi
  done
};
replace_text_in_folder() {
  search="$1"
  replace="$2"

  find . -type d | while read file; do
    newname=$(echo "$file" | sed "s/$search/$replace/")
    if [ "$file" != "$newname" ]; then
      mv "$file" "$newname";
    fi
  done
};
flatten_dir_and_rename_with_path() {
  find . -type f | while read file; do
    relpath=$(realpath --relative-to=. "$file")
    relpath=$(echo "$relpath" | sed 's/\//-/g')
    mv "$file" "./$relpath"
  done;
}

unzip aws-asset-package_07312022.zip -d icons;
cd icons;

rm -rf __MACOSX;
find . -type f -name ".DS_Store" -delete;

rm -rf Category-Icons_07312022;

# Architecture
cd Architecture-Service-Icons_07312022;

# 48x48 is the only size that all icons are provided in, remove all sizes
find . \
-type d -name "*16*" -exec rm -rf {} \; \
-o -type d -name "*32*" -exec rm -rf {} \; \
-o -type d -name "*64*" -exec rm -rf {} \;;

# subfolder naming includes both "Arch_48" and "48", convert to only 48
replace_text_in_folder "Arch_48" "48";

flatten_dir_and_rename_with_path;
find . -type d -name "48" -delete;
find . -type d -name "Arch_*" -delete;

find . -name "*.svg" -delete;
 
replace_text_in_filename "_48.png" ".png"; # trailing _48
replace_text_in_filename "-48-" "-"; # 48 folder
replace_text_in_filename "Arch_" ""; # starting Arch_
replace_text_in_filename "Arch_" ""; # Arch_ prepending filename

find . -type f -name "*_Dark.png" -delete
replace_text_in_filename "_Light.png" ".png"; # remove light

# product naming includes both "Amazon" and "AWS", convert to only AWS
replace_text_in_filename "-Amazon-" "-AWS-";

replace_text_in_filename_g "_" "-"; # remove _
replace_text_in_filename "-AWS-" "-"; # redundant AWS
replace_text_in_filename_g "-" ""; # remove -

cd ..;
cd Resource-Icons_07312022;

find . -name "*.svg" -delete;
find . -type d -name "*_Dark" -exec rm -rf {} \;;
replace_text_in_filename "_Light.png" ".png"; # remove light
replace_text_in_filename "_48.png" ".png"; # trailing _48

flatten_dir_and_rename_with_path;
find . -type d -name "Res_48*" -delete;
find . -type d -name "Res_*" -delete;
replace_text_in_filename "Res_" ""; # starting Res_
replace_text_in_filename "_48_Light-" "-"; 
replace_text_in_filename "Res-Res_" ""; 

# product naming includes both "Amazon" and "AWS", convert to only AWS
replace_text_in_filename "-Amazon-" "-AWS-";
replace_text_in_filename_g "_" "-"; # remove _
replace_text_in_filename "-AWS-" "-"; # redundant AWS
replace_text_in_filename_g "-" ""; # remove -

cd ..;
find . -type f -exec mv {} . \;
find . -type d -name "*Icons*" -delete;
replace_text_in_filename "AppIntegration" "ApplicationIntegration";
replace_text_in_filename "InternetofThingsIoT" "IoTIoT";
replace_text_in_filename "SecurityIdentityandCompliance" "SecurityIdentityCompliance";
