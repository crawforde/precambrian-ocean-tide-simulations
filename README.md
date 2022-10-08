# Mid-Archean Tide Simulation Plotting Scripts

## Requirements
- Matlab Version: 2018b
- Data from this data [repository](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/A32CT4) (see section below for more details).

## Download dataset
Navigate to the data [repository](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/A32CT4) for this project and download the `data` and `bathymetry` folders directly into the root folder of this repository. The file structure and the file names should be exactly the same as that shown by the data repository in order for this code to work out of the box.

## Up and Running
Set up your environment variables by copying the example env file:
```
cp sample.env .env
```
Open up `.env` and fill in the values according to the instructions in the comments.

Next, start Matlab and run the `setenv.m` script to export your environment variables and
install the third party libraries in the `vendor` folder.

You are now ready to run the plotting scripts contained in the `src` directory. Images created
will be automatically save to the `images` directory inside this repository. (If your Matlab
scripts complain about the missing folder, go ahead and create it yourself).
