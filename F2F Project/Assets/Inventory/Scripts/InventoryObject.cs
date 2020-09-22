using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using UnityEditor;
using System.Runtime.Serialization;

[CreateAssetMenu(fileName = "New Inventory", menuName = "Inventory System/Inventory")]
public class InventoryObject : ScriptableObject
{
    public string savePath;
    public ItemDatabaseObject database;
    public Inventory container;


    public bool AddItem(Item _item, int _quantity)
    {
        if (EmptySlotCount <= 0)
            return false;
        var slot = FindItemOnInventory(_item);
        if(!database.items[_item.id].stackable || slot == null)
        {
            SetEmptySlot(_item, _quantity);
            return true;
        }
        slot.AddAmount(_quantity);
        return true;
    }
    public int EmptySlotCount
    {
        get
        {
            var counter = 0;
            for (int i = 0; i < container.items.Length; i++)
            {
                if (container.items[i].item.id <= -1)
                {
                    counter++;
                }
            }
            return counter;
        }
    }
    public InventorySlot FindItemOnInventory(Item _item)
    {
        for (int i = 0; i < container.items.Length; i++)
        {
            if(container.items[i].item.id == _item.id)
            {
                return container.items[i];
            }
        }
        return null;
    }
    public InventorySlot SetEmptySlot(Item _item, int _quantity)
    {
        for (int i = 0; i < container.items.Length; i++)
        {
            if (container.items[i].item.id <= -1)
            {
                container.items[i].UpdateSlot(_item, _quantity);
                return container.items[i];
            }
        }
        //set up functionality for full inventory
        return null;
    }

    public void SwapItems(InventorySlot item1, InventorySlot item2)
    {
        if(item2.CanPlaceInSlot(item1.ItemObject) && item1.CanPlaceInSlot(item2.ItemObject))
        {
            InventorySlot temp = new InventorySlot( item2.item, item2.quantity);
            item2.UpdateSlot(item1.item, item1.quantity);
            item1.UpdateSlot(temp.item, temp.quantity);
        }
    }
    
//save and load functionality
    [ContextMenu("Save")]
    public void Save()
    {
        IFormatter formatter = new BinaryFormatter();
        Stream stream = new FileStream(string.Concat(Application.persistentDataPath, savePath), FileMode.Create, FileAccess.Write);
        formatter.Serialize(stream, container);
        stream.Close();
    }
    [ContextMenu("Load")]
    public void Load()
    {
        if (File.Exists(string.Concat(Application.persistentDataPath, savePath)))
        {
            IFormatter formatter = new BinaryFormatter();
            Stream stream = new FileStream(string.Concat(Application.persistentDataPath, savePath), FileMode.Open, FileAccess.Read);
            Inventory newContainer = (Inventory)formatter.Deserialize(stream);
            for (int i = 0; i < container.items.Length; i++)
            {
                container.items[i].UpdateSlot(newContainer.items[i].item, newContainer.items[i].quantity);
            }
            stream.Close();
        }
    }
    [ContextMenu("Clear")]
    public void Clear()
    {
        container.Clear();
    }
}
[System.Serializable]
public class Inventory
{
    public InventorySlot[] items = new InventorySlot[28];
    public void Clear()
    {
        for (int i = 0; i < items.Length; i++)
        {
            items[i].RemoveItem();
        }
    }
}

[System.Serializable]
public class InventorySlot
{
    public Item item = new Item();
    public ItemType[] permittedItemTypes = new ItemType[0];
    public int quantity;
    public UserInterface parent;
    
    public ItemObject ItemObject
    {
        get
        {
            if(item.id >= 0)
            {
                return parent.inventory.database.items[item.id];
            }
            return null;
        }
    }

    public InventorySlot()
    {
        item = new Item();
        quantity = 0;
    }
    public InventorySlot(Item _item, int _quantity)
    {
        item = _item;
        quantity = _quantity;
    }
    public void UpdateSlot(Item _item, int _quantity)
    {
        item = _item;
        quantity = _quantity;
    }
    public void RemoveItem()
    {
        item = new Item();
        quantity = 0;
    }
    public void AddAmount(int value)
    {
        quantity += value;
    }
    //limit item type
    public bool CanPlaceInSlot(ItemObject _itemObject)
    {
        if (permittedItemTypes.Length <= 0 || _itemObject == null || _itemObject.data.id < 0)
            return true;
        for (int i = 0; i < permittedItemTypes.Length; i++)
        {
            if (_itemObject.type == permittedItemTypes[i])
                return true;
        }
        return false;
    }
}