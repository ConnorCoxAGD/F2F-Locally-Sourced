using UnityEngine;
[CreateAssetMenu(fileName = "New Seed Object", menuName = "Inventory System/Items/Seeds")]

public class SeedObject : ItemObject
{
    public void Awake()
    {
        type = ItemType.Seeds;
    }
    
}