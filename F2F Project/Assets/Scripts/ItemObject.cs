using UnityEngine;

public enum ItemType
{
    Food,
    Equipment,
    Default,
}

public abstract class ItemObject : ScriptableObject
{
    public GameObject display;
    public ItemType type;
    [TextArea(15,20)]
    public string description;
}
