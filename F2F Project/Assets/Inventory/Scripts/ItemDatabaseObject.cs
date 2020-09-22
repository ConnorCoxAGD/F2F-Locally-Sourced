using UnityEngine;

[CreateAssetMenu(fileName = "New Item Database", menuName = "Inventory System/Items/Database")]
public class ItemDatabaseObject : ScriptableObject, ISerializationCallbackReceiver
{
    public ItemObject[] items;

    [ContextMenu("Update ID's")]
    public void UpdateID()
    {
        for (var i = 0; i < items.Length; i++)
        {
            if (items[i].data.id != i)
                items[i].data.id = i;
        }
    }
    public void OnAfterDeserialize()
    {
        UpdateID();
    }

    public void OnBeforeSerialize()
    {}
}