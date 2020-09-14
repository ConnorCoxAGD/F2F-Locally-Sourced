using UnityEngine;
[CreateAssetMenu(fileName = "New Equipment Object", menuName = "Inventory System/Items/Equipment")]

public class EquipmentObject : ItemObject
{
    public float atkBonus;
    public float defBonus;

    public void awake()
    {
        type = ItemType.Equipment;
    }
    
}
