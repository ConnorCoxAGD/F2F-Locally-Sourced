using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum ItemType 
{
    Equipment, Food, Recipe, Seeds, Default
}

public enum Attributes
{
    Agility,
    Intellect,
    Stamina,
    Strength
}
[CreateAssetMenu(fileName = "New Item", menuName = "Inventory System/Items/item")]
public class ItemObject : ScriptableObject
{

    public Sprite uiDisplay;
    public bool stackable = true;
    public ItemType type;
    [TextArea(15, 20)]
    public string description;
    public Item data = new Item();

}

[System.Serializable]
public class Item
{
    public int id = -1;
    public string Name;
    public Item()
    {
        id = -1;
        Name = "";
    }
    public Item(ItemObject item)
    {
        id = item.data.id;
        Name = item.name;
    }
}