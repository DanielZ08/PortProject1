/*

Cleaning Data in SQL Queries

*/

Select *
From PortfolioProject1.dbo.NashvilleHousing



-- Standardize Date Format 

Select SaleDateConverted, CONVERT(Date,SaleDate)
From PortfolioProject1.dbo.NashvilleHousing

Update NashvilleHousing
Set SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date; 

Update NashvilleHousing
Set SaleDateConverted = CONVERT(Date, SaleDate)



--Populate Propery Address Data

Select *
From PortfolioProject1.dbo.NashvilleHousing
--Where PropertyAddress is null
order by ParcelID

Select NashA.parcelID, NashA.PropertyAddress, NashB.ParcelID, NashB.PropertyAddress, ISNULL(NashA.PropertyAddress, NashB.PropertyAddress)
From PortfolioProject1.dbo.NashvilleHousing NashA
JOIN PortfolioProject1.dbo.NashvilleHousing NashB
	on NashA.parcelID = NashB.parcelID
	AND NashA.[UniqueID ] <> NashB.[UniqueID ]
Where NashA.PropertyAddress is null


Update NashA
SET PropertyAddress = ISNULL(NashA.PropertyAddress, NashB.PropertyAddress)
From PortfolioProject1.dbo.NashvilleHousing NashA
JOIN PortfolioProject1.dbo.NashvilleHousing NashB
	on NashA.parcelID = NashB.parcelID
	AND NashA.[UniqueID ] <> NashB.[UniqueID ]
Where NashA.PropertyAddress is null



-- Seperating Address into Individual Columns (Address, City, State)

Select PropertyAddress
From PortfolioProject1.dbo.NashvilleHousing
--Where PropertyAddress is null
--order by ParcelID

SELECT 
Substring (PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, Substring (PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address

From PortfolioProject1.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255); 

Update NashvilleHousing
Set PropertySplitAddress = Substring (PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) 

ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255); 

Update NashvilleHousing
Set PropertySplitCity = Substring (PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))


Select *
From PortfolioProject1.dbo.NashvilleHousing




Select OwnerAddress
From PortfolioProject1.dbo.NashvilleHousing


Select 
PARSENAME (REPLACE(OwnerAddress, ',','.'), 3) 
, PARSENAME (REPLACE(OwnerAddress, ',','.'), 2)
, PARSENAME (REPLACE(OwnerAddress, ',','.'), 1) 
From PortfolioProject1.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255); 

Update NashvilleHousing
Set OwnerSplitAddress = PARSENAME (REPLACE(OwnerAddress, ',','.'), 3) 

ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255); 

Update NashvilleHousing
Set OwnerSplitCity = PARSENAME (REPLACE(OwnerAddress, ',','.'), 2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255); 

Update NashvilleHousing
Set OwnerSplitState = PARSENAME (REPLACE(OwnerAddress, ',','.'), 1) 

Select *
From PortfolioProject1.dbo.NashvilleHousing




--Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject1.dbo.NashvilleHousing
Group by SoldAsVacant
Order by 2



Select SoldAsVacant
, CASE when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
	END
From PortfolioProject1.dbo.NashvilleHousing


Update NashvilleHousing
Set SoldAsVacant = CASE when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
	END






--Removing Duplicates 

WITH RowNumCTE AS ( 
Select * ,
	ROW_NUMBER() OVER (
	PARTITION by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PortfolioProject1.dbo.NashvilleHousing
)
Select *
From RowNumCTE
Where row_num > 1 
Order by PropertyAddress




--Deleting Unused Columns 


Select *
From PortfolioProject1.dbo.NashvilleHousing

ALTER Table PortfolioProject1.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress,

ALTER Table PortfolioProject1.dbo.NashvilleHousing
DROP COLUMN SaleDate